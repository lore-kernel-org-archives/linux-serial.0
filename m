From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v4 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
Date: Mon, 28 May 2018 12:08:02 +0200
Message-ID: <e1445467-2df0-4593-852d-939e6795f318@sorico.fr>
References: <20180525171941.26766-1-radu.pirea@microchip.com>
 <20180525171941.26766-7-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180525171941.26766-7-radu.pirea@microchip.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Radu Pirea <radu.pirea@microchip.com>, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 25/05/2018 19:19, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 40 +++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 18 deletions(-)
the stdout-path property of the chosen node is still broken in this verion.
if :
stdout-path = "serial0:115200n8";
is set in the DTS, the console output should go on serial0 (aka dbgu)
cf Documentation/devicetree/bindings/chosen.txt

With this patch applied, this is not the case anymore.
Adding console=ttyS0,115200 in the chosen node is not the solution here.


regards,
Richard.
