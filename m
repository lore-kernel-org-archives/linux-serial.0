From: Valdis.Kletnieks@vt.edu
Subject: Re: Q: what is the need for console write callback if there is serial
	tx (start_tx) ?
Date: Thu, 15 Sep 2016 16:50:02 -0400
Message-ID: <34480.1473972602@turing-police.cc.vt.edu>
References: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0838796954546186550=="
Return-path: <kernelnewbies-bounces@kernelnewbies.org>
In-Reply-To: <CAJ2oMhJQhazxs=G6oUB4mhFVy7=7p__+1z1Yq-MpJ0X6EtUVqg@mail.gmail.com>
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
	<mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Sender: kernelnewbies-bounces@kernelnewbies.org
Errors-To: kernelnewbies-bounces@kernelnewbies.org
To: Ran Shalit <ranshalit@gmail.com>
Cc: linux-serial@vger.kernel.org, kernelnewbies <kernelnewbies@kernelnewbies.org>
List-Id: linux-serial@vger.kernel.org

--===============0838796954546186550==
Content-Type: multipart/signed; boundary="==_Exmh_1473972602_2012P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1473972602_2012P
Content-Type: text/plain; charset=us-ascii

On Thu, 15 Sep 2016 23:19:51 +0300, Ran Shalit said:

> Isn't writing to console, the same as outputing chars to serial ?

No.  For instance, consider any laptop where "console" is an LCD screen,
and if it's recent hardware, there isn't a UART anywhere in the device, nor
is there a serial port to connect to.  Or any system where virtual terminals
are in the config, for that matter.

Then there's netconsole, console-over-USB, and heaven knows what other
variations.

See Documentation/console/console.txt  for more information.


--==_Exmh_1473972602_2012P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.5 07/13/2001

iQEVAwUBV9sJeY0DS38y7CIcAQIBaQf+MAKxMb0hUURtMbHLa11tWuBklYu7/ALV
TwfNWQ+P9CkBLv9i28qMb89aW+Wy3lpY+uShDF4dDoQkSOYkrfZ22s3i1Ip3qKMc
u06XxEMhrOhsfEXEJDqQkLNX4qFkvxynBxX7FTVk+4ZGSJDbesISuLuTMp+QUl2I
A2KQ1ixPcQ9pHPAFK5+ze4XW18FvjWonHHrYd/3UvJU59290XfsMgLoHRlzuXUut
FcmbcgUtrAbch4/t8r4FdXB8rwB557F9mOAbgmxBqeydRovGlV5sX/Ln8OWRKybc
mw28UAQ11gu16KcYDzsdMz9i36365Pr5d6hF2qXBN/dqs2Pm5aIYuQ==
=f40j
-----END PGP SIGNATURE-----

--==_Exmh_1473972602_2012P--


--===============0838796954546186550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies

--===============0838796954546186550==--
