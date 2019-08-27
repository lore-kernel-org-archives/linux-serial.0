From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: serial: lantiq: Convert to YAML
 schema
Date: Tue, 27 Aug 2019 12:21:23 -0500
Message-ID: <20190827172123.GA9417@bogus>
References: <cover.1566370151.git.rahul.tanwar@linux.intel.com>
 <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b8e0fa2981176dba29cd8e29f14532501cf962b4.1566370151.git.rahul.tanwar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: robh+dt@kernel.org, devicetree@vger.kernel.org, gregkh@linuxfoundation.org, mark.rutland@arm.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, andriy.shevchenko@intel.com, qi-ming.wu@intel.com, cheol.yong.kim@intel.com, rahul.tanwar@intel.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 21 Aug 2019 15:06:51 +0800, Rahul Tanwar wrote:
> Convert the existing DT binding document for Lantiq SoC ASC serial controller
> from txt format to YAML format.
> 
> Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
> ---
>  .../devicetree/bindings/serial/lantiq,asc.yaml     | 55 ++++++++++++++++++++++
>  .../devicetree/bindings/serial/lantiq_asc.txt      | 31 ------------
>  2 files changed, 55 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/lantiq,asc.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/lantiq_asc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
