From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] serial: 8250_uniphier: add auto-flow-control support
Date: Tue, 25 Sep 2018 04:24:35 -0700
Message-ID: <5baa1af4.1c69fb81.52980.4bc3@mx.google.com>
References: <1537334893-26079-1-git-send-email-yamada.masahiro@socionext.com>
 <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1537334893-26079-4-git-send-email-yamada.masahiro@socionext.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: Dai Okamura <okamura.dai@socionext.com>, devicetree@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Wed, 19 Sep 2018 14:28:13 +0900, Masahiro Yamada wrote:
> From: Dai Okamura <okamura.dai@socionext.com>
> 
> Add selective auto-flow-control support for UniPhier serial driver.
> 
> Signed-off-by: Dai Okamura <okamura.dai@socionext.com>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/devicetree/bindings/serial/uniphier-uart.txt | 3 +++
>  drivers/tty/serial/8250/8250_uniphier.c                    | 3 +++
>  2 files changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
