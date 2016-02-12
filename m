From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/9] ACPI: introduce acpi_table_parse2()
Date: Sat, 13 Feb 2016 00:07:00 +0100
Message-ID: <CAJZ5v0i2RCEEZwCN+Ran3Qmasn4yEk1rbfWkZ5QbEkUQWvaJ+g@mail.gmail.com>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
	<1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455299022-11641-4-git-send-email-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 12, 2016 at 6:43 PM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> The function acpi_table_parse() has some problems:
> 1 It can be called only from __init code
> 2 It does not pass any data to the handler
> 3 It just throws out the value returned from the handler

So why are those problems?

> These issues are addressed in this patch

How are they addressed?

Thanks,
Rafael
