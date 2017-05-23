From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Tue, 23 May 2017 08:24:18 +0300
Message-ID: <2f873a62-0e4e-7da6-5c5e-be570fcceff1@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
 <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
 <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
 <55bae8d2-0e23-b5e1-f304-63d9130ccb08@cogentembedded.com>
 <20170517070019.GG9913@b29396-OptiPlex-7040>
 <045d1888-4a23-cf73-ab4c-009e29fde974@cogentembedded.com>
 <20170519150722.GB23227@b29396-OptiPlex-7040>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519150722.GB23227@b29396-OptiPlex-7040>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: "A.S. Dong" <aisheng.dong@nxp.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Duan <fugang.duan@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi,

>>>> Alternative solution could be - have separate write path for earlycon.
>>>
>>> It looks to me having the same issue with a separate write patch
>>> for earlycon as we still need distinguish Little or Big endian
>>> for Layerscape and IMX.
>>>
>>>> At a glance, it is dozen lines of code.
>>>
>>> Would you please show some sample code?
>>
>> Do not reuse lpuart32_console_putchar() in earlycon code.
>>
>> Have two sets of early_setup/early_write/putchar - for BE and
>> defaut-endian earlycon. And in these putchar's do not use
>> lpuart_(read|write).
>>
> 
> Isn't that introducing another consistency break after fix one
> consistency break?
> 
> If doing that, we then have two register read/write APIs.
> One for normal driver operation by dynamically checking lpuart_is_be
> property to distinguish the endian difference problem.
> Another is specifically implemented for only early console read/write
> and use hardcoded way to read/write register directly instead of using
> the standard API lpuart32_read/write, like follows:
> e.g.
> lpuart32_le_console_write() {
> 	 writel();
> }
> 
> lpuart32_be_console_write() {
> 	 iowrite32be()
> }
> This also makes the driver a bit strange and ugly.
> 
> It looks to me both way are trade offs and the later one seems sacrifice
> more. And i doubt if it's really necessary for probably a no real gain
> purpose as the FPGA you mentioned is a theoretical case and less
> possibility to exist.
> 
> I'm still wondering how about keep using the exist way and adding more
> information in code to explain why use a global var?

I've checked other driver under drivers/tty/serial/, for examples of
similar cases.

Please look at serial8250_early_in() / serial8250_early_out() ?
These do handle different endian, via port->iotype

Another example is drivers/tty/serial/samsung.c, where
port->private_data is initialized and used.

Nikita
