From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/4] tty: serial: cpm_uart: Fix module autoload for OF
 platform driver
Date: Fri, 18 Sep 2015 19:25:30 -0500
Message-ID: <55FCAB7A.40403@tabi.org>
References: <20150918180314.GA30740@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150918180314.GA30740@goodgumbo.baconseed.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Fabian Frederick <fabf@skynet.be>, Wolfram Sang <wsa@the-dreams.de>, Peter Korsgaard <peter@korsgaard.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
>
> Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>

Acked-by: Timur Tabi <timur@tabi.org>
