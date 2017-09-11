From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
Date: Mon, 11 Sep 2017 11:11:49 +0200
Message-ID: <mvmzia1bnvu.fsf@suse.de>
References: <20160927151953.GB4371@kroah.com>
        <20160927205418.31529-1-aleksey.makarov@linaro.org>
        <20160927205418.31529-2-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160927205418.31529-2-aleksey.makarov@linaro.org> (Aleksey
        Makarov's message of "Tue, 27 Sep 2016 23:54:13 +0300")
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Sep 27 2016, Aleksey Makarov <aleksey.makarov@linaro.org> wrote:

> 'ARM Server Base Boot Requiremets' [1] mentions SPCR (Serial Port
> Console Redirection Table) [2] as a mandatory ACPI table that
> specifies the configuration of serial console.
>
> Defer initialization of DT earlycon until ACPI/DT decision is made.
>
> Parse the ACPI SPCR table, setup earlycon if required,
> enable specified console.

How can I tell the kernel to ignore this table and use the console on
the command line instead?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
