From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH v3] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 16:08:48 -0500
Message-ID: <37d33921-f1c7-3c65-515d-cf25c1d79585@codeaurora.org>
References: <20170215180159.11359-1-cov@codeaurora.org>
 <20170215195026.GN31733@leverpostej> <20170215200754.GA23091@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170215200754.GA23091@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, timur@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, nd@arm.com
List-Id: linux-serial@vger.kernel.org

On 02/15/2017 03:07 PM, Greg Kroah-Hartman wrote:
> On Wed, Feb 15, 2017 at 07:50:27PM +0000, Mark Rutland wrote:
>> On Wed, Feb 15, 2017 at 01:01:59PM -0500, Christopher Covington wrote:

>>> Due to known (although trivial) conflicts in silicon-errata.txt, based on
>>> http://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/log/?h=for-next/core

>> It might be best to split the silicon-errata doc into a separate patch.
>> That can go via the arm64 tree without conflict whiel the driver patch
>> can go via the tty tree.
> 
> Well, I can't take this as-is because I get conflicts in my tty tree
> with the doc, and with the driver itself:
> 
> 	checking file Documentation/arm64/silicon-errata.txt
> 	Hunk #1 FAILED at 68.
> 	1 out of 1 hunk FAILED
> 	checking file drivers/acpi/spcr.c
> 	checking file drivers/tty/serial/amba-pl011.c
> 	Hunk #5 FAILED at 2370.
> 	1 out of 8 hunks FAILED
> 
> I have no idea what the driver conflict is, what branch was this made
> against?

I'll make the split Mark suggested in v4, basing driver changes on
gregkh/tty tty-next unless someone suggests otherwise. (FWIW the previous
base was arm64/linux.git for-next/core.)

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
