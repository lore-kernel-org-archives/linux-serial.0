From: Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 2/2] tty: wipe buffer if not echoing data
Date: Wed, 3 Oct 2018 08:55:24 +0200
Message-ID: <bda5dd46-94bd-e8ff-d012-ac472a437f1d@gmail.com>
References: <20181002171708.1311-1-gregkh@linuxfoundation.org>
 <20181002171708.1311-3-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002171708.1311-3-gregkh@linuxfoundation.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jslaby@suse.com, aszlig@nix.build, torvalds@linux-foundation.org, w@1wt.eu, Greg KH <greg@kroah.com>
List-Id: linux-serial@vger.kernel.org

On 02/10/2018 19:17, Greg Kroah-Hartman wrote:
> From: Greg KH <greg@kroah.com>
> 
> If we are not echoing the data to userspace, then perhaps it is a
> "secret" so we should wipe it once we are done with it.

Just to explain our test case for cryptsetup, where aszlig initially reported it:

cryptsetup reads a passphrase from terminal, derives a candidate key for keyslot
decryption and immediately wipes the passphrase from memory, because it is
not needed anymore.

And here is the problem - the kernel keeps this passphrase in a tty buffer memory
that is no longer available to userspace. It can be retrieved from memory dump
later, even after the crypt mapping is destroyed.
Almost all userspace tools working with passphrases through tty access have
the same problem here.

> This mirrors the logic that the audit code has.
> 
> Reported-by: aszlig <aszlig@nix.build>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> Tested-by: aszlig <aszlig@nix.build>
> Cc: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/n_tty.c | 20 +++++++++++++++++---
...

>  static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
>  			    size_t tail, size_t n)
>  {
>  	struct n_tty_data *ldata = tty->disc_data;
>  	size_t size = N_TTY_BUF_SIZE - tail;
> -	const void *from = read_buf_addr(ldata, tail);
> +	void *from = read_buf_addr(ldata, tail);
>  	int uncopied;
>  
>  	if (n > size) {
>  		tty_audit_add_data(tty, from, size);
>  		uncopied = copy_to_user(to, from, size);
> +		zero_buffer(tty, from, size);

I think Linus mentioned in some previous mail that there should be
  zero_buffer(tty, from, size - uncopied);
to avoid wiping of yet uncopied data.

I tested the unmodified version though...

>  		if (uncopied)
>  			return uncopied;
>  		to += size;
> @@ -171,7 +182,9 @@ static int tty_copy_to_user(struct tty_struct *tty, void __user *to,
>  	}
>  
>  	tty_audit_add_data(tty, from, n);
> -	return copy_to_user(to, from, n);
> +	uncopied = copy_to_user(to, from, n);
> +	zero_buffer(tty, from, n);
> +	return uncopied;
>  }


Milan
