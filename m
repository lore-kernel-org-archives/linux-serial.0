From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
Date: Mon, 11 Sep 2017 13:39:36 +0200
Message-ID: <mvmingpbh1j.fsf@suse.de>
References: <20160927151953.GB4371@kroah.com>
        <20160927205418.31529-1-aleksey.makarov@linaro.org>
        <20160927205418.31529-2-aleksey.makarov@linaro.org>
        <mvmzia1bnvu.fsf@suse.de>
        <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net> (Leif
        Lindholm's message of "Mon, 11 Sep 2017 12:05:22 +0100")
Sender: linux-acpi-owner@vger.kernel.org
To: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Sep 11 2017, Leif Lindholm <leif.lindholm@linaro.org> wrote:

> Are you asking because you want to use a different console in a lab
> setup or because there are issues with SPCR on your platform?

The console from the SPCR is not the one forwarded by the BMC.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
