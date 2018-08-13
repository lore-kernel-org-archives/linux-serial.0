From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 18/18] dt-bindings: serial: lantiq: Add optional
 properties for CCF
Date: Mon, 13 Aug 2018 11:53:17 -0600
Message-ID: <20180813175317.GA31286@rob-hp-laptop>
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-19-songjun.wu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180803030237.3366-19-songjun.wu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@linux.intel.com>
Cc: hua.ma@linux.intel.com, yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com, linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 03, 2018 at 11:02:37AM +0800, Songjun Wu wrote:
> Clocks and clock-names are updated in device tree binding.
> 
> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> ---
> 
> Changes in v2: None
> 
>  Documentation/devicetree/bindings/serial/lantiq_asc.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
