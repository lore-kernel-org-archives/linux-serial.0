From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: console=ttyS1 breaks ttyS1 termios and prevents me from logging
 in
Date: Wed, 08 Apr 2015 17:29:21 -0400
Message-ID: <55259DB1.4080104@hurleysoftware.com>
References: <CALCETrVHeApB0_GxMkc88Giq6vLMpOz+wdZLmwhK7Ytumh2y6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CALCETrVHeApB0_GxMkc88Giq6vLMpOz+wdZLmwhK7Ytumh2y6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On 04/08/2015 05:17 PM, Andy Lutomirski wrote:
> Something strange seems to have happened to my serial console setup.
> I boot with console=ttyS1,115200n8 and I have a getty running on
> /dev/ttyS1.
> 
> On older kernels, or if I remove the console= boot parameter, then my
> getty works fine.  On 3.19.3 with the console= parameter, something's
> wrong with termios and I can't log in.  Running:

Thanks for the report.
1. Please attach your dmesg.
2. Is this behavior new to 3.19.3? (iow, what was the last version
   that you noticed didn't do this)

Regards,
Peter Hurley

> # stty icanon </dev/ttyS1
> 
> breaks line this (partial strace results included):
> 
> ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
> TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
> ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
> TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
> ioctl(0, SNDCTL_TMR_STOP or SNDRV_TIMER_IOCTL_GINFO or TCSETSW,
> {B115200 opost -isig icanon -echo ...}) = 0
> ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
> TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
> ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or
> TCGETS, {B115200 opost -isig -icanon -echo ...}) = 0
> write(2, "stty: ", 6stty: )                   = 6
> write(2, "standard input: unable to perfor"..., 58standard input:
> unable to perform all requested operations) = 58
> 
> IOW, the setting didn't stick.  On the bad kernel, stty works just
> fine on ttyS0.  If I switch to using console=ttyS0,115200, then stty
> works on ttyS1 and fails on ttyS0.
> 
> I have no idea what's going on here.  I have two apparently identical
> boxes.  One of them has this problem and the other doesn't.
