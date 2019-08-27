From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] dt-bindings: lantiq: Update for new SoC
Date: Tue, 27 Aug 2019 12:22:02 -0500
Message-ID: <20190827172202.GA10615@bogus>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
 <ffb6855d4c8d47412775b5fa4ce6ae4dd1161cb8.1566370151.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ffb6855d4c8d47412775b5fa4ce6ae4dd1161cb8.1566370151.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 21 Aug 2019 15:06:52 +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) reuses Lantiq ASC serial controller IP.
> Update the dt bindings to support LGM as well.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq,asc.yaml     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
