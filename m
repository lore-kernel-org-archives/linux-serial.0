From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 0/4] ACPI: parse the SPCR table
Date: Wed, 21 Sep 2016 18:38:23 +0200
Message-ID: <20160921163823.GB9373@kroah.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
 <20160921103749.GA7993@kroah.com>
 <CAOZdJXV2KyZAbrRxQ_zmFNd3Gn4vyuqSsUfJMTU8wpiOtjyE=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOZdJXV2KyZAbrRxQ_zmFNd3Gn4vyuqSsUfJMTU8wpiOtjyE=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Timur Tabi <timur@codeaurora.org>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <linux@arm.linux.org.uk>, Len Brown <lenb@kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <ahs3@redhat.com>, Christopher Covington <cov@codeaurora.org>, Yury Norov <ynorov@caviumnetworks.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Salter <msalter@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralis>
List-Id: linux-serial@vger.kernel.org

On Wed, Sep 21, 2016 at 11:19:35AM -0500, Timur Tabi wrote:
> On Wed, Sep 21, 2016 at 5:37 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > I thought you asked Rafael to take them, they are not in my queue
> > anymore because of that.  Don't try to shop-around for maintainers
> > please, that's kind of rude...
> 
> In Aleksey's defense, these patches have been floating around for far
> too long, so I can understand his frustration.

I understand the frustration as well, cross-maintainer messy patches
like this are hard to get merged at times at they fall between the
cracks a lot.

> But as you said, I really hope Rafael picks these up for 4.9.  We need
> these patches for ARM server.

I thought I saw an email saying he would do so, but it might have been
for some other patchset, sorry...

greg k-h
