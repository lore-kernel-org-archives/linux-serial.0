From: Ed Vance <EdV@macrolink.com>
Subject: RE: where can I find "serial_compat.h" file?
Date: Mon, 22 Apr 2002 09:54:38 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <11E89240C407D311958800A0C9ACF7D13A77A8@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org
To: '9c97cce5c9533ebe8f' <bai01@mails.tsinghua.edu.cn>
Cc: linux-serial@vger.kernel.org

On Sun, Apr 21, 2002 at 9:38 AM, bai01@mails.tsinghua.edu.cn wrote: 
> /*
>  * All of the compatibility code so we can compile serial.c against
>  * older kernels is hidden in serial_compat.h
>  */
> #if defined(LOCAL_HEADERS) || (LINUX_VERSION_CODE < 0x020317) /* 2.3.23 */
> #include "serial_compat.h"
> #endif
> 
>    But I can't find the "serial_compat.h" file,
>    Who can tell me where can I find it.
>    And I use serial.c with version "5.05c"
> 
>    Thanks!

Hi,

I would try the one that was released with driver rev 5.0.5 on SourceForge
at http://sourceforge.net/projects/serial/. 

Good luck,
Ed Vance

