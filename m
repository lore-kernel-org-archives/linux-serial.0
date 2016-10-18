From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 2/2] devicetree: bindings: uart: Add new compatible
 string for ZynqMP
Date: Tue, 18 Oct 2016 08:04:22 -0500
Message-ID: <20161018130422.2zjasatazwmmbsss@rob-hp-laptop>
References: <1476258448-20483-1-git-send-email-navam@xilinx.com>
 <1476258448-20483-2-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1476258448-20483-2-git-send-email-navam@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nava kishore Manne <nava.manne@xilinx.com>
Cc: gregkh@linuxfoundation.org, mark.rutland@arm.com, jslaby@suse.com, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, punnaia@xilinx.com, Nava kishore Manne <navam@xilinx.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 12, 2016 at 01:17:28PM +0530, Nava kishore Manne wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch Adds the new compatible string for ZynqMP SoC.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
> Changes for v6:
> 		-Added New compatiable string for ZynqMP SoC as
> 		 suggested by Rob Herring.
> Changes for v5:
> 		-Mofified the compatible session.
> Changes for v4:
>                 -Modified the ChangeLog comment.
> Changes for v3:
>                 -Added changeLog comment.
> Changes for v2:
>                 -None
> 
>  Documentation/devicetree/bindings/serial/cdns,uart.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
