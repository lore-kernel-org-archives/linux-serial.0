From: Christopher Covington <cov@codeaurora.org>
Subject: Re: [PATCH 1/2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 8 Feb 2017 16:57:35 -0500
Message-ID: <bd59cc0d-fcd6-aa7e-409f-1e363599b1a1@codeaurora.org>
References: <20170208005736.18724-1-cov@codeaurora.org>
 <7151be59-000c-d50b-f8f5-5fef0c053d91@arm.com>
 <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <f9504cde-a87a-ba99-2f72-fc3029ef5fe5@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Timur Tabi <timur@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Shanker Donthineni <shankerd@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Russell King <linux@armlinux.org.uk>, linux-serial@vger.kernel.org, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Sameer Goel <sgoel@codeaurora.org>, Philip Elcan <pelcan@codeaurora.org>, Steve Ulrich <sulrich@codeaurora.org>, Richard Ruigrok <rruigrok@codeaurora.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On 02/08/2017 08:27 AM, Timur Tabi wrote:
> Robin Murphy wrote:
>> Is there a reason anyone would ever want to turn this off? AFAICS you
>> save a few dozen bytes in return for a kernel image which you know won't
>> work properly on some hardware. That doesn't seem particularly
>> worthwhile, and it's not like the PL011 driver isn't already ripe with
>> unconditional vendor-specific data.

I'll make it unconditional in the next version.

>>> > +static bool qdf2400_e44(void) {
>>> > +    u32 cpu_var_model = read_cpuid_id() & ~MIDR_REVISION_MASK;
>>> > +
>>> > +    return (cpu_var_model == MIDR_QCOM_KRYO_V1 ||
>>> > +        cpu_var_model == MIDR_QCOM_FALKOR_V1);
> 
>> Are we to take it that every SoC now and always with any Kryo or Falkor
>> core which also has an SBSA UART will require this workaround?

I should have matched full 32 bit MIDR values, but I masked off the revision
number after careful investigation of current and future known MIDR values
and system pairings because MIDR_FOO isn't actually a 32 bit MIDR value as
the name would suggest but has variant and revision zeroed. The CPU in the
QDF2432 has a non-zero revision number and I didn't want to try to add an
unprecedented revision number to cputype.h after Will told me I wasn't
allowed to play with CPU toys for SoC games.

I'm going to stop using MIDR, but as an aside, there are two very different
CPUs, which may require different CPU errata workarounds, that (by accident)
only differ by the variant field. Robert Richter's recent MIDR_CPU_VAR_REV
is a welcome clarification.

> No, only Kryo and Falkor V1 based SOCs have this problem. Falkor V2
> will have this fixed.

A year ago, we were operating under the incorrect-in-hindsight assumption
that the QDF2400 v1 SoC with Falkor v1 CPU would have this fixed.

As for alternative means of identifying the errant hardware, I think that I
or a colleague will experiment with the approach used for ACPI PCI quirks:
checking the OEM ID, OEM Table ID, and OEM Revision. In this case, those
header fields would come from the Serial Port Console Redirection (SPCR)
table, rather than the PCI-specific MCFG table.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=5b69b85ba1ddd36be01f5c57830b37a3c8256009

Regarding ongoing support, I don't see any disagreement that the code must
be supported and maintained for the life of the hardware, however many years
that ends up being.

Thanks,
Cov

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc. Qualcomm Technologies, Inc. is a member of the Code
Aurora Forum, a Linux Foundation Collaborative Project.
