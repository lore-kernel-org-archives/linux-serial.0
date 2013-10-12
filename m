From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 2/2] tty/serial: at91: add a fallback option to
 determine uart/usart property
Date: Sat, 12 Oct 2013 17:00:10 +0200
Message-ID: <20131012170010.537982fb@skate>
References: <a58fe8bc7fdd128a2f9cf60785f81ebde4c0c247.1381394411.git.nicolas.ferre@atmel.com>
	<64f8f1db6f888456be8ee410a7e9bb9851d070a5.1381394411.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:55214 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751543Ab3JLPAT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Oct 2013 11:00:19 -0400
In-Reply-To: <64f8f1db6f888456be8ee410a7e9bb9851d070a5.1381394411.git.nicolas.ferre@atmel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Josh Wu <josh.wu@atmel.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, linux-kernel@vger.kernel.org

Dear Nicolas Ferre,

On Thu, 10 Oct 2013 10:43:32 +0200, Nicolas Ferre wrote:
> On older SoC, the "name" field is not filled in the register map.
> Fix the way to figure out if the serial port is an uart or an usart for these
> older products (with corresponding properties).
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Tested-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

On a Calao USB-A9263 board. Without this patch, 3.12-rc4 doesn't
boot properly on this board, it 'hangs' while configuring the serial
port.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
