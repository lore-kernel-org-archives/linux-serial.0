From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC PATCH] tty/serial: RS485 bindings for device tree
Date: Tue, 11 Oct 2011 19:28:06 +0200
Message-ID: <4E947CA6.9010703@atmel.com>
References: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, claudio@evidence.eu.com, jesper.nilsson@axis.com, alan@lxorguk.ukuu.org.uk
Cc: grant.likely@secretlab.ca, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

I can also add this new property (support for it already in linux-next):

On 10/11/2011 07:13 PM, Nicolas Ferre :
> Generic bindings for RS485 feature included in some UARTs.
> Those bindings have to be used withing an UART device tree node.
> Documentation updated to link to the bindings definition.

[..]

> +Optional properties:
> +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
> +  feature at boot time. It can be disabled later with proper ioctl.

+- linux,rs485-rx-during-tx: empty property that enable the receiving of data
+  even whilst sending data.

> +- linux,rs485-rts-delay: prop-encoded-array <a b> where:

[..]

Best regards,
-- 
Nicolas Ferre
