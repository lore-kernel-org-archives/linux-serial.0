From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/10] Documentation: dt: Tidy up the Marvell related
 files
Date: Tue, 2 Feb 2016 15:26:37 -0600
Message-ID: <20160202212637.GA24562@rob-hp-laptop>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
 <1454436468-4241-6-git-send-email-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454436468-4241-6-git-send-email-gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-ide-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 02, 2016 at 07:07:43PM +0100, Gregory CLEMENT wrote:
> Over the last releases we have added more and more Marvell related binding
> directly in the arm directory. It's time to have our proper directory
> inside it, and move all the files in it.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  .../devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt          | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt     | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt        | 0
>  .../devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt        | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt        | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt          | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt    | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt      | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt  | 0
>  Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt  | 0
>  .../devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt     | 0
>  14 files changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp-pmsu.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-370-xp.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-375.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-380-mpcore-soc-ctrl.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-38x.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-39x.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/armada-cpu-reset.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/coherency-fabric.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/kirkwood.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,berlin.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,dove.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/marvell,kirkwood.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-cpu-config.txt (100%)
>  rename Documentation/devicetree/bindings/arm/{ => marvell}/mvebu-system-controller.txt (100%)

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
