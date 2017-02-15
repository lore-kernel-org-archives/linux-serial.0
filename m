From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 12:24:16 +0000
Message-ID: <20170215122415.GG31733@leverpostej>
References: <20170214235347.8812-1-cov@codeaurora.org>
 <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>, Christopher Covington <cov@codeaurora.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Feb 14, 2017 at 08:39:40PM -0600, Timur Tabi wrote:
> Christopher Covington wrote:
 
> >+	if (!memcmp(table->header.oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
> >+		if (!memcmp(table->header.oem_table_id, "QDF2432 ",
> >+				ACPI_OEM_TABLE_ID_SIZE) ||
> >+				(!memcmp(table->header.oem_table_id,
> >+				"QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
> >+				table->header.oem_revision == 0))
> >+			uart = "qdf2400_e44";
> >+

Thanks for reworking this. I'm much happier with this than the MIDR
check.

Splitting out the test into its own function, as Timur suggested, would
generally be nicer. Minor comments on that below.

> static bool needs_qdf2400_e44(struct acpi_table_header *h)
> {

This is detecting the presence of the erratum so, has_qdf2400_e44() or
needs__qdf2400_e44_workaround() would be better names. I'd personally
prefer the former, but either is fine.

> 	const char *id;
> 
> 	/* The erratum only applies to Qualcomm Technologies SOCs */
> 	if (memcmp(h->oem_id, "QCOM  ", ACPI_OEM_ID_SIZE))
> 		return False;
> 
> 	id = h->oem_table_id;
> 
> 	if (!memcmp(id, "QDF2432 ", ACPI_OEM_TABLE_ID_SIZE))
> 		return True;
> 
> 	if (!memcmp(id, "QDF2000 ", ACPI_OEM_TABLE_ID_SIZE) &&
> 		h->oem_revision == 0)
> 		return True;
> 	
> 	return False;
> }

s/False/false/g
s/True/true/g

With that, this looks fine to me. I'm not too familiar with the pl011
driver. On the assumption the other changes have already been vetted:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
