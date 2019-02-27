From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 07/10] dt-bindings: serial: Add Milbeaut serial driver
 description
Date: Wed, 27 Feb 2019 16:04:50 +0100
Message-ID: <20190227150450.GA7056@kroah.com>
References: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1551243210-10826-1-git-send-email-sugaya.taichi@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sugaya Taichi <sugaya.taichi@socionext.com>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Takao Orito <orito.takao@socionext.com>, Kazuhiro Kasai <kasai.kazuhiro@socionext.com>, Shinji Kanematsu <kanematsu.shinji@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, Masami Hiramatsu <masami.hiramatsu@linaro.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Feb 27, 2019 at 01:53:30PM +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt

I have already queued this up in my tty tree for merging in 5.1-rc1.

thanks,

greg k-h
