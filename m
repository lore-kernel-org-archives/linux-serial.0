From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v8 4/4] serial: pl011: add console matching function
Date: Mon, 11 Jul 2016 17:50:16 +0200
Message-ID: <5783C038.5070504@gmail.com>
References: <1463749405-11640-1-git-send-email-aleksey.makarov@linaro.org>
 <1463749405-11640-5-git-send-email-aleksey.makarov@linaro.org>
 <20160622121813.GA20023@yury-N73SV>
 <7CC4D455-323E-4B33-A931-2104E2DDDC0D@hurleysoftware.com>
 <20160622204548.GB28766@yury-N73SV> <5783AFDE.1090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5783AFDE.1090408@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Russell King <linux@arm.linux.org.uk>, Graeme Gregory <graeme.gregory@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Leif Lindholm <leif.lindholm@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-acpi@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Jiri Slaby <jslaby@suse.com>, Al Stone <ahs3@redhat.com>, linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org



On 11/07/16 16:40, Matthias Brugger wrote:

>
> I tried to apply these patches against linux-next. They needed some
> changes to apply, which is quite normal after such a long time. Apart
> from that the DBG2 subtype patch didn't end up in mainline, so this
> patches do not compile.
>
> I followed up on that on the corresponding thread. Please don't forget
> to pin-point in the introduction mail to any other series which is
> needed for your patches to compile/work.
>

Ok, I sorted out, that the DBG2 subtypes actually are part of mainline 
and that I screwed up my branches.

Sorry for the noise.
Matthias
