From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Does braille console work?
Date: Fri, 17 Mar 2017 10:16:13 +0100
Message-ID: <20170317091613.r6ddbzf27qg5whjc@var.youpi.perso.aquilenet.fr>
References: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
 <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
 <6657242f-e4a9-f142-a6eb-f0c07a7d04f3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6657242f-e4a9-f142-a6eb-f0c07a7d04f3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <amakarov.linux@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Aleksey Makarov, on ven. 17 mars 2017 12:00:02 +0300, wrote:
> I think removing it is a good idea

Removing potential for accessibility is almost never a good idea.

Getting that code in was difficult because it required introducing
accessibility features in the rest of the core. Removing that code means
that some time later somebody will suggest removing those accessibility
feature, thus making the work of somebody who wants to add accessibility
support even harder, while it is already crazily hard.

Samuel
