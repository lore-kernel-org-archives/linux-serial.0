From: Patrice Chotard <patrice.chotard@st.com>
Subject: Re: [PATCH 1/3] ARM: dts: STiH410-b2260: Identify the UART RTS line
Date: Tue, 6 Dec 2016 09:39:11 +0100
Message-ID: <8bda7a96-cd16-f245-f2d8-296816aaafb1@st.com>
References: <20161202141146.31281-1-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161202141146.31281-1-lee.jones@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com
List-Id: linux-serial@vger.kernel.org

Hi Lee

Except the typo in patch 2

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks

On 12/02/2016 03:11 PM, Lee Jones wrote:
> Configure the UART RTS line as a GPIO for manipulation within the UART driver.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih410-b2260.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/stih410-b2260.dts b/arch/arm/boot/dts/stih410-b2260.dts
> index 7fb507f..f46603f 100644
> --- a/arch/arm/boot/dts/stih410-b2260.dts
> +++ b/arch/arm/boot/dts/stih410-b2260.dts
> @@ -63,6 +63,7 @@
>  		uart0: serial@9830000 {
>  			label = "LS-UART0";
>  			status = "okay";
> +			rts-gpios = <&pio17 3 GPIO_ACTIVE_LOW>;
>  		};
>  
>  		/* Low speed expansion connector */
> 
