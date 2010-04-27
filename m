From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: handling flow control for console device
Date: Tue, 27 Apr 2010 20:09:06 +0530
Message-ID: <j2id6a0f7aa1004270739l96b8ba58h74d18cb206f47e7b@mail.gmail.com>
References: <C1859C32A5123B49B7BC37C19355B37A24F842695D@USNAVSXCHMBSA3.ndc.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f179.google.com ([209.85.221.179]:57285 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969Ab0D0OjH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Apr 2010 10:39:07 -0400
Received: by qyk9 with SMTP id 9so19426340qyk.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Apr 2010 07:39:06 -0700 (PDT)
In-Reply-To: <C1859C32A5123B49B7BC37C19355B37A24F842695D@USNAVSXCHMBSA3.ndc.alcatel-lucent.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Kittlitz, Edward (Ned)" <ned.kittlitz@alcatel-lucent.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Wed, Apr 21, 2010 at 12:38 AM, Kittlitz, Edward (Ned)
<ned.kittlitz@alcatel-lucent.com> wrote:
> Hello,
>
> I've been trying to figure out the Linux philosophy on
> flow control for console devices.
>
> We have several situations where flow control
> can stop bootup or normal operation. =A0For us, it's more
> important that things keep running; console output has
> lower priority.
>
> I thought there would be some way to forcibly disable
> flow control for the console. But I can not find any way
> to do it. =A0In my case, it's XOFF flow control.
>

During boot up most of tty drivers will be using tty_std_termios settin=
gs
when we do an uart_register_driver, init_termios will be set to tty_std=
_termios.

And looking into tty_std_termios we have

 .c_iflag =3D ICRNL | IXON,

here IXON is enabled by default.

tty_std_termios ---> "drivers/char/tty_io.c"

---
Regards,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
