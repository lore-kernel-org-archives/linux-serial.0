From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 00/14] serial: langtiq: Add CCF suppport
Date: Mon, 15 Oct 2018 21:58:47 +0000
Message-ID: <20181015215845.5t7bkyks6hsxqwsb@pburton-laptop>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Content-Language: en-US
Content-ID: <65EBC5B044F99A4EA8A4F4D65B6EADD1@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: "yixin.zhu@linux.intel.com" <yixin.zhu@linux.intel.com>, "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>, "hauke.mehrtens@intel.com" <hauke.mehrtens@intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, James Hogan <jhogan@kernel.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Rob Herring <robh+dt@kernel.org>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-serial@vger.kernel.org

Hi Songjun,

On Mon, Sep 24, 2018 at 06:27:49PM +0800, Songjun Wu wrote:
> This patch series is for adding common clock framework support
> for langtiq serial driver, mainly includes:

s/langtiq/lantiq/ ...

> 1) Add common clock framework support.
> 2) Modify the dts file according to the DT conventions.
> 3) Replace the platform dependent functions with kernel functions
>=20
> Songjun Wu (14):
>   MIPS: dts: Change upper case to lower case
>   MIPS: dts: Add aliases node for lantiq danube serial
>   serial: lantiq: Get serial id from dts
>   serial: lantiq: Change ltq_w32_mask to asc_update_bits
>   MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
>   serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
>   serial: lantiq: Rename fpiclk to freqclk
>   serial: lantiq: Replace clk_enable/clk_disable with clk generic API
>   serial: lantiq: Add CCF support
>   serial: lantiq: Reorder the head files
>   include: Add lantiq.h in include/linux/
>   serial: lantiq: Replace lantiq_soc.h with lantiq.h
>   serial: lantiq: Change init_lqasc to static declaration
>   dt-bindings: serial: lantiq: Add optional properties for CCF

It appears that you only copied me on patches 1, 2 & 5. I've applied
patch 1 to mips-next for 4.20, but I have no clue whether your other
patches were deemed acceptable by serial or DT maintainers & I have no
context for the changes being made, so I can neither apply nor ack
patches 2 & 5. Please copy me on the whole series next time.

Thanks,
    Paul
