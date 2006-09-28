From: Badari Pulavarty <pbadari@us.ibm.com>
Subject: [KJ] few questions on mxser driver (cleanups)
Date: Thu, 28 Sep 2006 09:04:15 -0700
Message-ID: <1159459455.1709.66.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <kernel-janitors-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/kernel-janitors>
List-Post: <mailto:kernel-janitors@lists.osdl.org>
List-Help: <mailto:kernel-janitors-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/kernel-janitors>,
	<mailto:kernel-janitors-request@lists.osdl.org?subject=subscribe>
Sender: kernel-janitors-bounces@lists.osdl.org
Errors-To: kernel-janitors-bounces@lists.osdl.org
To: kernel-janitors@lists.osdl.org, linux-serial@vger.kernel.org
Cc: alan@redhat.com, rmk+serial@arm.linux.org.uk
List-Id: linux-serial@vger.kernel.org

Hi,

I was fixing request_region() error checks and realized few things
about mxser driver (char/mxser.c) - I want to confirm before fixing
them.

1) mxser_get_PCI_conf() and mxser_get_ISA_conf() doesn't check
errors of request_region(). I think these should be checked and
return failures. Can we treat request_region() failures as corresponding
MXSER_ERR_* failures, instead of returning new error code (like -EIO)?

2) mxser_get_PCI_conf() currently doesn't return error - but the
caller checks for various error codes. Is this a oversight or it can't
happen with PCI ? If so, can we nix error checking at the caller ?

Thanks,
Badari
