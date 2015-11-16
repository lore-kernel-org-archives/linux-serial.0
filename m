From: Andrey Vostrikov <av.linux.dev@gmail.com>
Subject: MFD device driver on top of UART/RS232
Date: Mon, 16 Nov 2015 19:24:58 +0300
Message-ID: <564A035A.3050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-embedded-owner@vger.kernel.org>
Sender: linux-embedded-owner@vger.kernel.org
To: linux-serial@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

I have an embedded system with microcontroller connected via UART/RS232 port. This microcontroller implements several low-level functions that need to be exposed as device drivers in other subsystems (watchdog, LEDs, HWMON, firmware read/write).

I checked many drivers implemented in the kernel, searched through mail list archives and it looks like there are three different ways to solve this task:
A) most of the devices that are connected using UART have user space program that configures and manages it (either directly or with help of dedicated line discipline, SLIP, SL-CAN, etc)
B) serio - mostly used for input devices
C) direct use of UART port taking control from serial_core.

The best match I have found so far is MFD driver for Atmel Microcontroller on iPaq h3xxx (drivers/mfd/ipaq-micro.c) that follows concept "C)"

Is this a good enough example to use for this task? This platform is a legacy one so I am confused a little if new driver will fit nicely into the mainline.

It would be great if someone could point me to another example to follow or advise better way to implement MFD driver without user space involvement.

Best regards,
Andrey
