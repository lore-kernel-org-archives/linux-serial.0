From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: Nonterministic hang during bootconsole/console handover on ath79
Date: Tue, 22 Mar 2016 08:38:48 -0700
Message-ID: <56F16708.4020109@hurleysoftware.com>
References: <56F07DA1.8080404@universe-factory.net>
 <56F0B189.2080206@hurleysoftware.com> <56F143A8.6020601@universe-factory.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F143A8.6020601@universe-factory.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Schiffer <mschiffer@universe-factory.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 03/22/2016 06:07 AM, Matthias Schiffer wrote:
> I've tried your patch and I can't reproduce the issue anymore with it; I
> have no idea if this actually has to do something with the issue, or the
> change of the code path just hid the bug again.
> 
> Regarding your other mail: with "small change", I was not talking about
> adding an additional printk; as mentioned, even changing the numbers in
> UTS_VERSION can hide the issue. I diffed a working and a broken kernel
> image, and the UTS_VERSION is really the only difference. I have no idea
> how to explain this.

If _any_ change may hide the problem, that will make it impossible
to determine if any attempted fix actually works, regardless of what
debugging method you use.

FWIW, you could still use the boot console to debug the problem by
disabling the regular command-line console.

Regards,
Peter Hurley


> (OpenWrt uses an LZMA-compressed kernel image, so
> after compression, the differences are much greater; but how these
> differences would affect the kernel after decompression eludes me)
> 
> I'll continue searching for a board with accessible JTAG which exhibits
> this issue. Given the heisenbuggy nature of the issue, getting to the root
> cause is probably impossible without JTAG unless someone has an obvious
> explanation...
> 
> Thanks,
> Matthias
> 
