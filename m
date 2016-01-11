From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH v4 3/3] serial: amba-pl011: add ACPI support to AMBA probe
Date: Mon, 11 Jan 2016 15:38:54 -0600
Message-ID: <569420EE.5060006@codeaurora.org>
References: <1450880383-29560-1-git-send-email-aleksey.makarov@linaro.org>
 <1450880383-29560-4-git-send-email-aleksey.makarov@linaro.org>
 <CAOZdJXUpjWi7Dy=GFi7_58FqD_UZxxrw_QKJ4sdHLKVOLCyNAA@mail.gmail.com>
 <CAGCh1+ksWFLkE8Y_a5SW98tpgGBWdVH5TYJAoS17EExuPd65oQ@mail.gmail.com>
 <568BEDEC.5010101@codeaurora.org>
 <20160106110350.GB3599@xora-haswell.xora.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160106110350.GB3599@xora-haswell.xora.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
To: Graeme Gregory <gg@slimlogic.co.uk>
Cc: G Gregory <graeme.gregory@linaro.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andy.shevchenko@gmail.com>, lkml <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, Shannon Zhao <shannon.zhao@linaro.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Vladimir Zapolskiy <vz@mleia.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Graeme Gregory wrote:
>> >
>> >So with this patch, what is the difference between sbsa_uart_probe and
>> >pl011_probe?  Shouldn't the patch also remove sbsa_uart_probe?
>> >
> One is for amba_device and one is for platform_device and one maintainer
> indicated displeasure at platfrom device being in an AMBA driver.

Ok, I'm still a little confused, but it sounds to me like your patch 
should have also removed sbsa_uart_probe().

With your patches applied, under what circumstance would 
sbsa_uart_probe() still be called?  The amba-pl011.c driver already 
probes on ARMH0011, so shouldn't that be removed, to avoid a double probe?

