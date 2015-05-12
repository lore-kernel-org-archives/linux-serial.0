From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH] serial/amba-pl011: Unconditionally poll for FIFO space
 before each TX char
Date: Tue, 12 May 2015 16:00:27 +0200
Message-ID: <20150512160027.21244f64@north>
References: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431438266-28094-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, linux-serial@vger.kernel.org, Andre Przywara <Andre.Przywara@arm.com>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 12 May 2015 14:44:26 +0100, Dave Martin wrote:
> This will cause a conflict with tty-next because it pulls forward
> some changes made by commit 1e84d22 (serial/amba-pl011: Refactor and
> simplify TX FIFO handling); however, the resolution is simple except
> for the following lines which may need to be deleted manually from
> amba-pl011.c:pl011_startup():

By resolution is simple you mean: keep the code as it is in tty-next,
right?
