From: Graeme Gregory <graeme.gregory@linaro.org>
Subject: Re: [PATCH v11 2/4] ACPI: parse SPCR and enable matching console
Date: Mon, 11 Sep 2017 13:24:47 +0100
Message-ID: <CAGCh1+=eqF_pgLmVYPLA1peudTUO6jvn4yVzL349J4n9=uVt6Q@mail.gmail.com>
References: <20160927151953.GB4371@kroah.com> <20160927205418.31529-1-aleksey.makarov@linaro.org>
 <20160927205418.31529-2-aleksey.makarov@linaro.org> <mvmzia1bnvu.fsf@suse.de>
 <20170911110522.vwgwnohjrrj2twtk@bivouac.eciton.net> <mvmingpbh1j.fsf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <mvmingpbh1j.fsf@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Andreas Schwab <schwab@suse.de>
Cc: Leif Lindholm <leif.lindholm@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On 11 September 2017 at 12:39, Andreas Schwab <schwab@suse.de> wrote:
> On Sep 11 2017, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>
>> Are you asking because you want to use a different console in a lab
>> setup or because there are issues with SPCR on your platform?
>
> The console from the SPCR is not the one forwarded by the BMC.
>
Considering the SPCR table in question seems mildly insane, you could
always unload the SPCR in grub.

Graeme
