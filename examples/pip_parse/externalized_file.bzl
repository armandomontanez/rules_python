def _externalized_file_impl(rctx):
    src_file_path = rctx.path(rctx.attr.src)
    file_name = src_file_path.basename
    rctx.file(
        file_name,
        content=rctx.read(src_file_path),
    )
    rctx.file(
        "BUILD.bazel",
        content="exports_files([\"{}\"])\n".format(file_name),
    )

externalized_file = repository_rule(
    implementation = _externalized_file_impl,
    attrs = {
        "src": attr.label(mandatory=True, allow_single_file=True),
    },
)
