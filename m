From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v3] tty: pl011: Work around QDF2400 E44 stuck BUSY bit
Date: Wed, 15 Feb 2017 12:44:27 -0600
Message-ID: <f26b71df-9a5b-ced7-5364-699f5df8891a@codeaurora.org>
References: <20170215180159.11359-1-cov@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170215180159.11359-1-cov@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Christopher Covington <cov@codeaurora.org>, Jonathan Corbet <corbet@lwn.net>, Marc Zyngier <marc.zyngier@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Peter Hurley <peter@hurleysoftware.com>, Aleksey Makarov <aleksey.makarov@linaro.org>, Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org, shankerd@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-acpi@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Mark Langsdorf <mlangsdo@redhat.com>, Mark Salter <msalter@redhat.com>, Jon Masters <jcm@redhat.com>, Neil Leeder <nleeder@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On 02/15/2017 12:01 PM, Christopher Covington wrote:
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Acked-by: Timur Tabi <timur@codeaurora.org>

It would great if we could get this into 4.11.  As crazy it sounds, it is the 
only critical patch in 4.11 that we need for our platform.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
