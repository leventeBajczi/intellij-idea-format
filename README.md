# IntelliJ IDEA Format

Run `docker run -v $PWD:/github/workspace ghcr.io/leventebajczi/intellij-format:latest "*.java,*.kts,*.kt" "" "./<intellij-stylesheet.xml>"` to format the current working directory's java, kts, and kt files according to the stylesheet.

To use as an action:

```yaml
    - name: Reformat
      uses: leventeBajczi/intellij-idea-format@v1.0
      with:
        settings-file: "./doc/ThetaIntelliJCodeStyle.xml"
        file-mask: "*.java,*.kts,*.kt"
        additional-options: "-dry" # omit this to actually reformat the code

    - name: Create Pull Request # this will create a pull request towards the current branch with the modifications
      uses: peter-evans/create-pull-request@153407881ec5c347639a548ade7d8ad1d6740e38
      with:
        commit-message: "Reformatted code"
        branch: "code-reformat"
        title: '[AutoPR] Reformatted code'
```
