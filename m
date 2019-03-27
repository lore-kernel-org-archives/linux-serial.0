From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH v2 0/4] Add new features for the Spreadtrum serial controller
Date: Wed, 27 Mar 2019 09:59:56 +0800
Message-ID: <CAMz4ku+00Bt0viM0JfKdy0n51EF9Hc37auKa6GPCHp8o=J6L8g@mail.gmail.com>
References: <cover.1551689518.git.baolin.wang@linaro.org> <CAMz4kuJitF7Q76T0Hoj1-UTAjQnepEs9aQHhy=r_Acdq+RiwGw@mail.gmail.com>
 <20190327005944.GA20301@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190327005944.GA20301@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Mark Brown <broonie@kernel.org>, lanqing.liu@unisoc.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 27 Mar 2019 at 08:59, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 26, 2019 at 06:41:31PM +0800, Baolin Wang wrote:
> > Hi Greg,
> >
> > On Mon, 4 Mar 2019 at 16:59, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > This patch set fixes the baud rate calculation formula issue, as well as
> > > adding power management support and DMA mode support for the Spreadtrum
> > > serial controller.
> > >
> > > Changes from v1:
> > >  - The patch 1 of V1 was applied, so remove the baud rate fix from this patch set.
> > >  - Add reviewed tag from Rob for patch 1.
> > >  - Fix the incorrect names' order in patch 3.
> >
> > Could you apply this patch set if no objection from you? Thanks.
>
> It's in my to-review queue, sorry, will get to it soon...

Thanks :)

--
Baolin Wang
Best Regards
