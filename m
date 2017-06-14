From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] tty/serial: remove AVR32 specific access wrappers
Date: Wed, 14 Jun 2017 09:43:44 +0200
Message-ID: <b3c66ec1-1f5b-3d46-79b4-3420f1e754d6@gmail.com>
References: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170613202517.26558-1-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 13/06/2017 22:25, Alexandre Belloni wrote:
> Now that AVR32 is gone, the specific wrappers for that architecture are
> unnecessary and will not be compiled anymore.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Richard Genoud <richard.genoud@gmail.com>
