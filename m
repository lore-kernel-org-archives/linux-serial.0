From: Bich HEMON <bich.hemon@st.com>
Subject: Re: [PATCH] can: m_can: select pinctrl state in each suspend/resume
 function
Date: Mon, 12 Mar 2018 08:50:03 +0000
Message-ID: <405c95e3-00e4-ad2a-f5b5-c5e7e2e5abdf@st.com>
References: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1519907380-15135-1-git-send-email-bich.hemon@st.com>
Content-Language: en-US
Content-ID: <F5627FA88C6B13438188C842E03EFC1C@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi all,

On 03/01/2018 01:29 PM, Bich HEMON wrote:
> Make sure to apply the correct pin state in suspend/resume callbacks.
> Putting pins in sleep state saves power.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>   drivers/net/can/m_can/m_can.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 2594f77..a86ef69 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1700,6 +1700,8 @@ static __maybe_unused int m_can_suspend(struct device *dev)
>   		m_can_clk_stop(priv);
>   	}
>   
> +	pinctrl_pm_select_sleep_state(dev);
> +
>   	priv->can.state = CAN_STATE_SLEEPING;
>   
>   	return 0;
> @@ -1710,6 +1712,8 @@ static __maybe_unused int m_can_resume(struct device *dev)
>   	struct net_device *ndev = dev_get_drvdata(dev);
>   	struct m_can_priv *priv = netdev_priv(ndev);
>   
> +	pinctrl_pm_select_default_state(dev);
> +
>   	m_can_init_ram(priv);
>   
>   	priv->can.state = CAN_STATE_ERROR_ACTIVE;
> 

Sorry, my mistake. Of course this is the wrong mailing list. Please 
ignore this patch.

Best regards,

Bich
