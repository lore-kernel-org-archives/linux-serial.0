From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] serial: 8250: include <linux/serial_reg.h> from serial_8250.h
Date: Tue, 26 May 2015 09:36:57 -0400
Message-ID: <556476F9.6040403@hurleysoftware.com>
References: <1432614528-13605-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432614528-13605-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/26/2015 12:28 AM, Masahiro Yamada wrote:
> The header file, include/linux/serial_8250.h, contains references to
> UART_LSR_BRK_ERROR_BITS and UART_MSR_ANY_DELTA that are defined in
> <linux/serial_reg.h>.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
