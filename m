From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] tty: serial core: decouple pm states from ACPI
Date: Fri, 7 Dec 2012 11:47:46 +0000
Message-ID: <20121207114746.07240a22@bob.linux.org.uk>
References: <1354876568-10617-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53894 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756174Ab2LGLpL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Dec 2012 06:45:11 -0500
In-Reply-To: <1354876568-10617-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rickard Andersson <rickard.andersson@stericsson.com>, linux-acpi@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

On Fri, 7 Dec 2012 11:36:08 +0100
Linus Walleij <linus.walleij@stericsson.com> wrote:

> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The serial core is using power states lifted from ACPI for no
> good reason. Remove this reference from the documentation and
> alter all users to use an enum specific to the serial core
> instead, and define it in <linux/serial_core.h>.

Ok fair enough.. if its confusing people. Seems daft to me but there we
are 8)

Acked-by: Alan Cox <alan@linux.intel.com>
