From: sathesh babu <sathesh_edara2003-/E1597aS9LQxFYw1CcD5bw@public.gmane.org>
Subject: MIPS Crosstoolchain for MIPS24K with dsp amd 24k
	compiler options
Date: Sat, 20 Oct 2007 09:07:07 +0100 (BST)
Message-ID: <712862.82132.qm@web7908.mail.in.yahoo.com>
References: <Pine.LNX.4.64N.0710192135440.13279@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0976479810=="
Return-path: <buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64N.0710192135440.13279-ZLUVCuZeNS790TmaoATp/9Ui29CwQgaX@public.gmane.org>
List-Unsubscribe: <http://busybox.net/mailman/listinfo/buildroot>,
	<mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=unsubscribe>
List-Archive: <http://busybox.net/lists/buildroot>
List-Post: <mailto:buildroot-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org>
List-Help: <mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=help>
List-Subscribe: <http://busybox.net/mailman/listinfo/buildroot>,
	<mailto:buildroot-request-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org?subject=subscribe>
Mime-version: 1.0
Sender: buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
Errors-To: buildroot-bounces-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
To: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, buildroot-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
List-Id: linux-serial@vger.kernel.org

--===============0976479810==
Content-Type: multipart/alternative; boundary="0-1611430905-1192867627=:82132"
Content-Transfer-Encoding: 7bit

--0-1611430905-1192867627=:82132
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=20
  =20
  I would like to build cross toolchain for MIPS24K processor with "-mdsp=
" and
   "-m24k" compile flag options for linux-2.6.18.8 kernel.
  =20
  I tried with below combinations of
  - GCC-4.2.1,GCC-4.0.1, GCC-4.1.0
  - binutils-2.15, binutil-2.17,binutil-2.18=20
  -  uClibc-0.9.27=20
  but i couldn't succeed any of the above combinations.
  =20
  I checked the mailing list and it is mentioned that GCC-4.2.x version o=
f gcc has problems.
  =20
  Could you please guide me the, the exact versions of
   - GCC=20
   - binutils
   - ucLibc
  to be used to build toolchain with "-mdsp" and "-m24k" compiler options=
 for linux-2.6.18.8 kernel version.
  =20
  Thanks.=20
  =20
  Regards,
  Sathesh

      =20
---------------------------------
 Bollywood, fun, friendship, sports and more. You name it,  we have it.
--0-1611430905-1192867627=:82132
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi, </div>  <div>&nbsp;</div>  <div>I would like to build cross tool=
chain for MIPS24K processor with "-mdsp" and</div>  <div>&nbsp;"-m24k" co=
mpile flag options for linux-2.6.18.8 kernel.</div>  <div>&nbsp;</div>  <=
div>I tried&nbsp;with below combinations of</div>  <div>- GCC-4.2.1,GCC-4=
.0.1, GCC-4.1.0</div>  <div>- binutils-2.15, binutil-2.17,binutil-2.18&nb=
sp;</div>  <div>- &nbsp;uClibc-0.9.27 </div>  <div>but i couldn't succeed=
 any of the above combinations.</div>  <div>&nbsp;</div>  <div>I checked =
the mailing list and it is mentioned that GCC-4.2.x version of gcc has pr=
oblems.</div>  <div>&nbsp;</div>  <div>Could you please guide me the, the=
 exact versions of</div>  <div>&nbsp;- GCC&nbsp;</div>  <div>&nbsp;- binu=
tils</div>  <div>&nbsp;- ucLibc</div>  <div>to be used to build toolchain=
 with "-mdsp" and "-m24k"&nbsp;compiler options for linux-2.6.18.8 kernel=
 version.</div>  <div>&nbsp;</div>  <div>Thanks.&nbsp;</div>  <div>&nbsp;=
</div>  <div>Regards,</div>=20
 <div>Sathesh</div><p>&#32;


      <!--1--><hr size=3D1></hr> Bollywood, fun, friendship, sports and m=
ore. You name it, <a href=3D"http://in.rd.yahoo.com/tagline_groups_1/*htt=
p://in.promos.yahoo.com/groups"> we have it.</a>
--0-1611430905-1192867627=:82132--

--===============0976479810==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
buildroot mailing list
buildroot-2zL2ArBv0bUdnm+yROfE0A@public.gmane.org
http://busybox.net/mailman/listinfo/buildroot
--===============0976479810==--
