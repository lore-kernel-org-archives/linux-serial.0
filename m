From: "9c97cce5c9533ebe8f" <bai01@mails.tsinghua.edu.cn>
Subject: where can I find "serial_compat.h" file?
Date: Mon, 22 Apr 2002 00:38:12 +0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020421164008Z313557-22651+13100@vger.kernel.org>
Reply-To: "9c97cce5c9533ebe8f" <bai01@mails.tsinghua.edu.cn>
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi all:
   
   In the linux kernel drivers/char/serial.c, it has:

/*
 * All of the compatibilty code so we can compile serial.c against
 * older kernels is hidden in serial_compat.h
 */
#if defined(LOCAL_HEADERS) || (LINUX_VERSION_CODE < 0x020317) /* 2.3.23 */
#include "serial_compat.h"
#endif

   But I can't find the "serial_compat.h" file,
   Who can tell me where can I find it.
   And I use serial.c with version "5.05c"

   Thanks!


