/*
 * Copyright (C) 2012 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <sys/ioctl.h>
#include <sys/resource.h>
#include <sys/prctl.h>
#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>

#define LOG_TAG "VibratorHW"
#include "cutils/log.h"

#define TSPDRV_MAGIC_NUMBER                 0x494D4D52

#define TSPDRV_STOP_KERNEL_TIMER            _IO(TSPDRV_MAGIC_NUMBER & 0xFF, 1)
#define TSPDRV_ENABLE_AMP                   _IO(TSPDRV_MAGIC_NUMBER & 0xFF, 3)
#define TSPDRV_DISABLE_AMP                  _IO(TSPDRV_MAGIC_NUMBER & 0xFF, 4)

int vibrator_exists()
{
    return 1;
}

int sendit(int timeout_ms)
{
    int ret, tspd, tspret;
    char value[20];
    int dummy = 0;
    int actuator = 0;
    char vibsample[4];

    vibsample[0] = 0; vibsample[1] = 8; vibsample[2]=1; 
    vibsample[3] = 96;

    tspd = open("/dev/tspdrv", O_RDWR);
    if(tspd < 0) {
        ALOGE("failed on opening /dev/tspdrv\n");
        close(tspd);
	return -1;
    } else {
        ALOGV("opened device /dev/tspdrv\n");
    }

    if(timeout_ms > 0) {
        /* enable tspdrv amp */
        ioctl(tspd, TSPDRV_ENABLE_AMP, &actuator);
        ioctl(tspd, TSPDRV_MAGIC_NUMBER, &actuator);
        write(tspd, &vibsample, 4); // First hit triggers the sample processing
        write(tspd, &vibsample, 4); // Now do it for real
        if(tspret != 0) {
            ALOGE("TSPDRV_ENABLE_AMP error\n");
        } else {
            ALOGV("TSPDRV_ENABLE_AMP success\n");
        }
    }

    ALOGV("timeout_ms: %d\n", timeout_ms);

    if(timeout_ms == 0) {
        /* disable tspdrv amp */
        tspret = ioctl(tspd,TSPDRV_DISABLE_AMP, &dummy);
        if(tspret != 0) {
            ALOGE("TSPDRV_DISABLE_AMP error\n");
        } else {
            ALOGV("TSPDRV_DISABLE_AMP success\n");
        }
    }

    close(tspd);

    return 0;
}
