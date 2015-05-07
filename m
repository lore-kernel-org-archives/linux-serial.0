From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/2] Documentation/magic-number: Remove SCI_MAGIC
Date: Thu, 7 May 2015 10:02:56 -0600
Message-ID: <20150507100256.70414d73@lwn.net>
References: <1430761191-23663-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1430761191-23663-1-git-send-email-geert+renesas@glider.be>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@zh-kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon,  4 May 2015 19:39:50 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> The SCI_MAGIC define was removed in commit f8e53553f452dcbf ("serial:
> sh-sci: Kill off more unused defines.").
> Its last user was the old drivers/char sh-sci driver, which was removed
> in 2004.

Dunno...do we really want to rush into these things? :)

Applied to the docs tree, thanks.

jon
