From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: Re: [PATCH 2/2] serial: mps2-uart: support combined tx and rx irq
Date: Wed, 30 Jan 2019 09:00:43 +0000
Message-ID: <db2e9569-b16a-2386-b482-d12275d06b86@arm.com>
References: <1548425597-38175-1-git-send-email-vladimir.murzin@arm.com>
 <1548425597-38175-3-git-send-email-vladimir.murzin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1548425597-38175-3-git-send-email-vladimir.murzin@arm.com>
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
To: linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com
List-Id: linux-serial@vger.kernel.org

On 1/25/19 2:13 PM, Vladimir Murzin wrote:
> It turns out that some designs went for implementing only combined tx
> and rx interrupt, which is currently not supported by the driver.
> Support of combined irq is built on top of existent irq handlers and
> activated by the hint form device tree.
> 

It seems that folks combine rx, tx and overrun interrupts, so I'll send v2

Cheers
Vladimir
