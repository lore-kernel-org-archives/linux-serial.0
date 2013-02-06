From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: drop unnecessary dependencies on TTY
Date: Wed, 6 Feb 2013 11:17:06 -0800
Message-ID: <20130206191706.GA27985@core.coreip.homeip.net>
References: <1360115914-4334-1-git-send-email-jmillenbach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360115914-4334-1-git-send-email-jmillenbach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Millenbach <jmillenbach@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Jiri Slaby <jirislaby@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Josh Triplett <josh@joshtriplett.org>, Jamey Sharp <jamey@minilop.net>
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 05, 2013 at 05:58:34PM -0800, Joe Millenbach wrote:
> Backing out changes made in earlier TTY removal patch.  Switched
> to only one dependency in SERPORT on TTY instead of many incorrect
> dependencies.
> 
> Signed-off-by: Joe Millenbach <jmillenbach@gmail.com>
> Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks for doing this!

-- 
Dmitry
