From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 07/17] dt-bindings: serial: Document Actions Semi Owl
 UARTs
Date: Mon, 27 Feb 2017 18:16:19 -0600
Message-ID: <20170228001619.aksrqgoqelxvui6v@rob-hp-laptop>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-8-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20170224034055.18807-8-afaerber@suse.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Mark Rutland <mark.rutland@arm.com>, support@lemaker.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, arm@kernel.org, mp-cs@actions-semi.com, linux-serial@vger.kernel.org, 96boards@ucrobotics.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 24, 2017 at 04:40:45AM +0100, Andreas F=E4rber wrote:
> This UART is found on S500 and S900 SoCs.
> =

> Signed-off-by: Andreas F=E4rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Adopted "actions" vendor prefix
>  =

>  .../devicetree/bindings/serial/actions,owl-uart.txt      | 16 ++++++++++=
++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/actions,owl-=
uart.txt

Acked-by: Rob Herring <robh@kernel.org>
