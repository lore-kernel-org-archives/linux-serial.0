From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 00/25] tty: serial: drop uart_port->lock before calling
Date: Fri, 16 Aug 2013 08:06:26 -0400
Message-ID: <520E15C2.7030108@hurleysoftware.com>
References: <cover.1376651114.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:47379 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754366Ab3HPMGd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 08:06:33 -0400
In-Reply-To: <cover.1376651114.git.viresh.kumar@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linaro-kernel@lists.linaro.org, patches@linaro.org, linux-serial@vger.kernel.org, Bryan Huntsman <bryanh@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, David Brown <davidb@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Tobias Klauser <tklauser@distanz.ch>, Tony Prisk <linux@prisktech.co.nz>

On 08/16/2013 07:43 AM, Viresh Kumar wrote:
> The -rt patch triggers a lockdep warning for serial drivers if
> tty_flip_buffer_push() is called with uart_port->lock locked. This never shows
> up on UP kernels.

Please include the lockdep warning in the changelog.

Does this happen on linux-next?

Regards,
Peter Hurley

