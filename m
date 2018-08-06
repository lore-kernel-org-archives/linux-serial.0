From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 05/18] dt-binding: MIPS: Add documentation of Intel
 MIPS SoCs
Date: Mon, 6 Aug 2018 09:16:06 -0600
Message-ID: <CAL_JsqLMZbDuUsqbg63P-pO4D_L6PHqhJqj2NXfu9xwmu3Rabw@mail.gmail.com>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com> <20180803030237.3366-6-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180803030237.3366-6-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin zhu <yixin.zhu@linux.intel.com>, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, Linux-MIPS <linux-mips@linux-mips.org>, linux-clk <linux-clk@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ralf Baechle <ralf@linux-mips.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 2, 2018 at 9:03 PM Songjun Wu <songjun.wu@linux.intel.com> wrote:
>
> From: Hua Ma <hua.ma@linux.intel.com>
>
> This patch adds binding documentation for the
> compatible values of the Intel MIPS SoCs.
>
> Signed-off-by: Hua Ma <hua.ma@linux.intel.com>
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
>
> Changes in v2:
> - New patch split from previous patch
> - Add the board and chip compatible in dt document
>
>  Documentation/devicetree/bindings/mips/intel.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mips/intel.txt

Reviewed-by: Rob Herring <robh@kernel.org>
