From: Amit Kucheria <akucheria@metricsystems.com>
Subject: RE: access to RS-232 signals from user-space?
Date: Wed, 26 Mar 2003 15:32:10 -0800
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1048721530.1468.20.camel@amit.metricsystems.com>
References: <11E89240C407D311958800A0C9ACF7D1A33E02@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from amit.metricsystems.com
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx04.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.10 (built Jan 23 2003))
 with ESMTP id <0HCD00HZIQPKSF@chimmx04.algx.net> for
 linux-serial@vger.kernel.org; Wed, 26 Mar 2003 17:32:09 -0600 (CST)
In-reply-to: <11E89240C407D311958800A0C9ACF7D1A33E02@EXCHANGE>
List-Id: linux-serial@vger.kernel.org
To: Ed Vance <EdV@macrolink.com>
Cc: linux-serial <linux-serial@vger.kernel.org>

Thanks Ed.

I have a few more doubts, but I will reserve them for until after I have
written some code to test out the capabilities of serial port
communications on Linux.

Regards,
Amit

----------------------------------------------------------------------
Amit Kucheria          akucheria@NOSPAMmetricsystems.com
Metric Systems Corp.   2320 Cousteau Court, Suite 201, Vista, CA 92083
----------------------------------------------------------------------

On Wed, 2003-03-26 at 14:39, Ed Vance wrote:
> Hi Amit,
> 
> The following ioctl calls are implemented in the generic serial driver,
> /usr/src/linux*/drivers/char/serial.c:
> 
>   Modem Lines
>      On special files representing serial ports, the  modem  con-
>      trol  lines  supported  by the hardware can be read, and the
>      modem status lines supported by the hardware can be changed.
>      The  following  modem  control  and status lines may be sup-
>      ported by a device; they are defined by <asm/termios.h>:
> 
>           TIOCM_DTR      data terminal ready
>           TIOCM_RTS      request to send
>           TIOCM_CTS      clear to send
>           TIOCM_CAR      carrier detect
>           TIOCM_RNG      ring
>           TIOCM_DSR      data set ready
>           TIOCM_OUT1     UART OUT1 signal
>           TIOCM_OUT2     UART OUT2 signal
> 
>      TIOCM_CD is a synonym  for  TIOCM_CAR,  and  TIOCM_RI  is  a
>      synonym for TIOCM_RNG. Not all of these are necessarily sup-
>      ported by any particular device; check the manual  page  for
>      the device in question.
> 
>      TIOCMBIS       The argument is a pointer  to  an  int  whose
>                     value  is  a  mask  containing  modem control
>                     lines to be turned  on.   The  control  lines
>                     whose bits are set in the argument are turned
>                     on; no other control lines are affected.
> 
>      TIOCMBIC       The argument is a pointer  to  an  int  whose
>                     value  is  a  mask  containing  modem control
>                     lines to be turned off.   The  control  lines
>                     whose bits are set in the argument are turned
>                     off; no other control lines are affected.
> 
>      TIOCMGET       The argument is a pointer  to  an  int.   The
>                     current  state  of  the modem status lines is
>                     fetched and stored in the int pointed  to  by
>                     the argument.
> 
>      TIOCMSET       The argument is a pointer to an int  contain-
>                     ing  a  new  set of modem control lines.  The
>                     modem control lines are  turned  on  or  off,
>                     depending on whether the bit for that mode is
>                     set or clear.
> 
> Cheers,
> Ed
> 
> ---------------------------------------------------------------- 
> Ed Vance              edv (at) macrolink (dot) com
> Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
> ----------------------------------------------------------------




