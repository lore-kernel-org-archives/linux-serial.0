From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 06/18] MIPS: dts: Change upper case to lower case
Date: Mon, 6 Aug 2018 09:14:54 -0600
Message-ID: <CAL_JsqLyuFsfXsG7g10D5g1uLXrFHJ9rdHc97AP9G+pj88v+xg@mail.gmail.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-7-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803030237.3366-7-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Paul Burton <paul.burton@mips.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> All the upper case in unit-address and hex constants are
> changed to lower case according to the Linux conventions.

It is DT conventions, not Linux.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2: None
>
>  arch/mips/boot/dts/lantiq/danube.dtsi   | 42 ++++++++++++++++-----------------
>  arch/mips/boot/dts/lantiq/easy50712.dts | 14 +++++------
>  2 files changed, 28 insertions(+), 28 deletions(-)
