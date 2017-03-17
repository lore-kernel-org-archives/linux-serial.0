From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Does braille console work?
Date: Fri, 17 Mar 2017 01:53:55 +0100
Message-ID: <20170317005355.xwym3zpamym3rwp6@var.youpi.perso.aquilenet.fr>
References: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: linux-serial@vger.kernel.org, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

Aleksey Makarov, on jeu. 16 mars 2017 17:02:53 +0300, wrote:
> There can be 3 outcomes from this function:
> 1) it returns NULL and does not set brl_options
> 2) it returns NULL and set the variable pointed by str to NULL
> 3) it returns non-NULL

Uh, that's odd indeed, the intent was that it'd return an error code
only.

> To register a braille console (i. e. to call __add_preferred_console()
> with non-NULL brl_options) function _braille_console_setup() should
> return NULL and initialize brl_options. 

return 0 (as in no error), actually, in the intent.

> 1) in this case brl_options is NULL and non-braille console is registered
> 2) kernel produces oops later in console_setup().  I reproduced it
>    passing "console=brl=aaa" parameter to kernel, see below.
> 3) no console is registered
> 
> So braille console registration should not work.  What do I miss?

Nothing, the code transformation was broken :/

> So it looks like braille console has not been used for more than 3 years.
> Should we remote it?

Please, no :)

It is indeed not often useful, since one would usually use a userland
daemon to access the system, but when one's system does not boot
properly or something similar, it's useful to have the braille
console. That's just very not often useful.

Samuel
