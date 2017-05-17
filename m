From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [V2, 2/6] tty: serial: lpuart: add little endian 32 bit register
 support
Date: Wed, 17 May 2017 09:25:51 +0300
Message-ID: <55bae8d2-0e23-b5e1-f304-63d9130ccb08@cogentembedded.com>
References: <1494834539-17523-3-git-send-email-aisheng.dong@nxp.com>
 <b4a2ed13-c71f-c973-3b09-b632e083a88b@cogentembedded.com>
 <20170517033139.GB9913@b29396-OptiPlex-7040>
 <48819894-4943-7d14-ccf8-83cfd2195c9a@cogentembedded.com>
 <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AM3PR04MB306D5C86AED120D15C4D46A80E70@AM3PR04MB306.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "A.S. Dong" <aisheng.dong@nxp.com>, Dong Aisheng <dongas86@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andy Duan <fugang.duan@nxp.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "Y.B. Lu" <yangbo.lu@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stefan@agner.ch" <stefan@agner.ch>, Mingkai Hu <mingkai.hu@nxp.com>, "jslaby@suse.com" <jslaby@suse.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

>> Code should be consistent.
>>
> 
> Yes.
> 
>> There is no good reason to have sport->lpuart32 inside sport, but
>> lpuart_is_be outside of it. Both these values describe properties of
>> particular device, and thus should be in per-device structure.
>>
> 
> That's for special case, normally we wouldn't do that.

For me this "special case" looks like "let's break data structure
consistency to reuse several lines of code".

With code snippets you show, it looks even worse: you assign same global
variable in several places for different uses. implicitly assuming that
it is for same device. Which can be true in your current system, but not
elsewhere (e.g. why not having lpuart programmed into fpga)?

Alternative solution could be - have separate write path for earlycon.
At a glance, it is dozen lines of code.
