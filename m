From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Fri, 19 May 2017 23:07:22 +0800
Message-ID: <20170519150722.GB23227@b29396-OptiPlex-7040>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
 <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
 <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
 <55bae8d2-0e23-b5e1-f304-63d9130ccb08@cogentembedded.com>
 <20170517070019.GG9913@b29396-OptiPlex-7040>
 <045d1888-4a23-cf73-ab4c-009e29fde974@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <045d1888-4a23-cf73-ab4c-009e29fde974@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: "A.S. Dong" <aisheng.dong@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Duan <fugang.duan@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 17, 2017 at 11:04:04AM +0300, Nikita Yushchenko wrote:
> Hi
> 
> My view of your statement is:
> - you currently assume only a few cases for this driver - builtin UART
> in vf610, ls1012a and imx7,
> - in each of these cases, all lpuart instances share same endian, thus
> having that in global var works for these cases,
> - having that in global var makes it possible for you to write less
> lines of code
> 
> My complain is:
> - in Linux, we are trying to keep drivers generic,
> - in Linux, having less lines of code has never been sufficient to break
> basic data structure consistency,
> - having driver to keep per-device capability in global var is a clear
> case of breaking consistency.
> 

Yes, i do understand your concern and i absolutely agree with the rule
you mentioned.

> 
> >>> That's for special case, normally we wouldn't do that.
> >>
> >> For me this "special case" looks like "let's break data structure
> >> consistency to reuse several lines of code".
> >>
> >> With code snippets you show, it looks even worse: you assign same global
> >> variable in several places for different uses. 
> > 
> > If you mean lpuart_is_be, it's not for different uses.
> > The purpose is the same to align the correct endian but in two places.
> 
> _probe() routine called for device X alters state already in use for
> device Y.
> 

Okay, you're saying two different types of devices appeared in one SoC.

> > 
> >> implicitly assuming that
> >> it is for same device. Which can be true in your current system, but not
> >> elsewhere (e.g. why not having lpuart programmed into fpga)?
> >>
> > 
> > Sorry, What issues for fpga?
> 
> Connect FPGA to IMX7 based system and program LS1012a version of lpuart
> core into it.  Have your console on system UART broken at time when
> driver gets registered.
> 

Well, theoretically it may happen.

> 
> > 
> >> Alternative solution could be - have separate write path for earlycon.
> > 
> > It looks to me having the same issue with a separate write patch
> > for earlycon as we still need distinguish Little or Big endian
> > for Layerscape and IMX.
> > 
> >> At a glance, it is dozen lines of code.
> > 
> > Would you please show some sample code?
> 
> Do not reuse lpuart32_console_putchar() in earlycon code.
> 
> Have two sets of early_setup/early_write/putchar - for BE and
> defaut-endian earlycon. And in these putchar's do not use
> lpuart_(read|write).
> 

Isn't that introducing another consistency break after fix one
consistency break?

If doing that, we then have two register read/write APIs.
One for normal driver operation by dynamically checking lpuart_is_be
property to distinguish the endian difference problem.
Another is specifically implemented for only early console read/write
and use hardcoded way to read/write register directly instead of using
the standard API lpuart32_read/write, like follows:
e.g.
lpuart32_le_console_write() {
	 writel();
}

lpuart32_be_console_write() {
	 iowrite32be()
}
This also makes the driver a bit strange and ugly.

It looks to me both way are trade offs and the later one seems sacrifice
more. And i doubt if it's really necessary for probably a no real gain
purpose as the FPGA you mentioned is a theoretical case and less
possibility to exist.

I'm still wondering how about keep using the exist way and adding more
information in code to explain why use a global var?

Regards
Dong Aisheng

> 
> As far as I can see, fsl_lpuart.c already has two drivers in one -
> there is separate set of routines for 8bit and 32bit cases.
> And those routines that are common, have if blocks that separate cases.
> I think these drivers will be cleaner if separated.
> However that's completely different story.
