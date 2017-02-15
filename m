From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v2] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 08:05:34 -0600
Message-ID: <2d3173f5-8818-21cd-eccd-10fc6d5ec3bd@codeaurora.org>
References: <20170214235347.8812-1-cov@codeaurora.org>
 <6a3ea0e5-f824-380e-1c4a-3e72b160e98a@codeaurora.org>
 <09772d07b3d6782690728ea171ac6e9e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <09772d07b3d6782690728ea171ac6e9e@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org, Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redh>
List-Id: linux-serial@vger.kernel.org

Christopher Covington wrote:
> Nothing needs QDF2400 erratum 44. Software should try to detect the presence
> of the erratum. So I think qdf2400_e44_detected or qdf2400_e44_present would
> make sense. But those suffixes don't add substantial value in my opinion.

I'd be okay with qdf2400_e44_detected or qdf2400_e44_present.  I think it's a 
lot clearer.  Another idea is "has_qdf2400_e44".

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
