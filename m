From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v10 0/4] ACPI: parse the SPCR table
Date: Tue, 27 Sep 2016 17:19:53 +0200
Message-ID: <20160927151953.GB4371@kroah.com>
References: <20160905123617.18775-1-aleksey.makarov@linaro.org>
 <25d32778-e708-6763-7cb2-4ddbeebc844b@linaro.org>
 <20160921103749.GA7993@kroah.com>
 <CAOZdJXV2KyZAbrRxQ_zmFNd3Gn4vyuqSsUfJMTU8wpiOtjyE=g@mail.gmail.com>
 <20160921163823.GB9373@kroah.com>
 <98ed1e6b-0994-4429-c085-2293b4a89edf@linaro.org>
 <3529130a-d44d-3160-4fbc-9827f8d94196@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3529130a-d44d-3160-4fbc-9827f8d94196@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Timur Tabi <timur@codeaurora.org>, "Zheng, Lv" <lv.zheng@intel.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Peter Hurley <peter@hurleysoftware.com>, Graeme Gregory <graeme.gregory@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, Leif Lindholm <leif.lindholm@linaro.org>, linux-acpi@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>, Yury Norov <ynorov@caviumnetworks.com>, Christopher Covington <cov@codeaurora.org>, linux-serial@vger.kernel.org, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 26, 2016 at 12:48:47PM -0700, Aleksey Makarov wrote:
> 
> 
> On 09/21/2016 10:22 AM, Aleksey Makarov wrote:
> > 
> > 
> > On 09/21/2016 07:38 PM, Greg Kroah-Hartman wrote:
> > > On Wed, Sep 21, 2016 at 11:19:35AM -0500, Timur Tabi wrote:
> > > > On Wed, Sep 21, 2016 at 5:37 AM, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > > 
> > > > > I thought you asked Rafael to take them, they are not in my queue
> > > > > anymore because of that.  Don't try to shop-around for maintainers
> > > > > please, that's kind of rude...
> > > > 
> > > > In Aleksey's defense, these patches have been floating around for far
> > > > too long, so I can understand his frustration.
> > > 
> > > I understand the frustration as well, cross-maintainer messy patches
> > > like this are hard to get merged at times at they fall between the
> > > cracks a lot.
> > > 
> > > > But as you said, I really hope Rafael picks these up for 4.9.  We need
> > > > these patches for ARM server.
> > > 
> > > I thought I saw an email saying he would do so, but it might have been
> > > for some other patchset, sorry...
> > 
> > This can be for "ACPI: ARM64: support for ACPI_TABLE_UPGRADE":
> > 
> > 	https://lkml.kernel.org/r/CAJZ5v0goXsQ2umcDXU0six+QtxcKGZq7mxhgxuvXTH2iZt6YNA@mail.gmail.com
> > 
> > As for this patchset, Rafael ACKed the ACPI part:
> > 
> > 	https://lkml.kernel.org/r/CAJZ5v0hdoLTfjrD8+WxSoxM48dqbZK2KwY_h+63kHKHKgO=JFA@mail.gmail.com
> > 
> > but I can not find any acknowledge from him that he is ready to merge the series.
> > On the contrary, he expressed his doubt that he is "the right maintainer to send this to":
> > 
> > 	https://lkml.kernel.org/r/CAJZ5v0gzjtFzig7nEumr83+J2dGb+OA8GNR2i45ZqznfV_hA-A@mail.gmail.com
> > 
> > I asked the ARM64 people, they said they prefer Rafael to do that:
> > 
> > 	https://lkml.kernel.org/r/20160909151758.GA11418@arm.com
> > 
> > I interpreted the silence from Rafael as unwillingness to pull the series
> > and thought it's OK to ask you.
> > 
> > I am sorry if this looks rude for Rafael, I did not mean that.
> 
> Hi Greg,
> 
> Can you give advise on how to deal with this situation please?
> 
> It looks like Rafael does not want to pull the patches.  Some time ago he wrote:
> 
> "Honestly, I'm not sure why I'm regarded as the right maintainer to send this to.
> 
> The only patch here touching generic ACPI code is [3/5] (the [2/5] is
> going in through ACPICA) and the rest is all about ARM64 AFAICS.  Why
> don't you send it to the ARM64 maintainers instead?"
> 
> (https://lkml.kernel.org/r/CAJZ5v0gzjtFzig7nEumr83+J2dGb+OA8GNR2i45ZqznfV_hA-A@mail.gmail.com)
> 
> ARM64 maintainer said
> 
> "The series should go via Rafael, since the bulk of the changes are
> outside of arch/arm64."
> 
> (https://lkml.kernel.org/r/20160909151758.GA11418@arm.com)
> 
> So should I continue to try to reach Rafael or ask another maintainer?
> Can you pull it for 4.9?

crazy, no one wants to touch this :)

So, do you have acks from all of the relevant people?  If so, sure, I
can take it, can you resend me a full copy of the patches and I'll queue
them up?

thanks,

greg k-h
